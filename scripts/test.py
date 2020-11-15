#!/usr/bin/env python3
import glob, yaml
import unittest

from yaml.loader import SafeLoader

from fuzzy import string_dist


class SafeLineLoader(SafeLoader):
    def construct_mapping(self, node, deep=False):
        mapping = super(SafeLineLoader, self).construct_mapping(node, deep=deep)
        # Add 1 so line numbering starts at 1
        mapping['__line__'] = node.start_mark.line + 1
        return mapping


class TestingContentFiles(unittest.TestCase):
    KONVENTEN = "content/konventen/*"
    VERENIGINGEN = "./content/verenigingen/*"
    PROJECTEN = "content/projecten/*"
    QUIZ = "content/quiz/*"

    @staticmethod
    def loadHeader(filename):
        lines = []
        loading = False
        with open(filename) as f:
            for line in f.readlines():
                if "---" in line:
                    if loading:
                        return yaml.load("".join(lines), Loader=SafeLineLoader)
                    else:
                        loading = True
                if loading:
                    lines.append(line)

    def test_checkAllSyntax(self):
        for location in [self.KONVENTEN, self.VERENIGINGEN, self.PROJECTEN, self.QUIZ]:
            for f in glob.glob(location, recursive=True):
                try:
                    self.loadHeader(f)
                except yaml.parser.ParserError as e:
                    raise yaml.parser.ParserError("Yaml error in " + f + "\n" + e)


    def getIds(self, location):
        out = []
        for ver in glob.glob(location, recursive=True):
            if ver[-2:] != "md":
                continue
            header = self.loadHeader(ver)
            assert header, "No headers found " + ver
            assert "id" in header, "NO ID FOUND " + ver

            out.append(header["id"])

        return out

    def test_getVerIds(self):
        return self.getIds(self.VERENIGINGEN)

    def test_checkVerHasExistingKonvent(self):
        konventen = self.getIds(self.KONVENTEN)
        for ver in glob.glob(self.VERENIGINGEN, recursive=True):
            if ver[-2:] != "md":
                continue
            header = self.loadHeader(ver)
            if "konvent" in header:
                if header["konvent"] not in konventen:
                    print("No existing konvent " + ver)
            else:
                print("NO KONVENT FOUND " + ver)

    def fuzzy_closest(self, x, xs):
        min_v = min(xs, key=lambda y: string_dist(x, y))
        return (min_v, string_dist(x, min_v))

    def checkQuiz(self, header, verenigingen, id):
        if "antwoorden" in header:
            for antwoord in header["antwoorden"]:
                if "verenigingen" in antwoord:
                    for ver in antwoord["verenigingen"]:
                        if ver["naam"] not in verenigingen:
                            min_v, dist_v = self.fuzzy_closest(ver['naam'], verenigingen)
                            if dist_v < 4:
                                assert ver[
                                           "naam"] not in verenigingen, f"{id}:{ver['__line__']} unknown '{ver['naam']}' did you mean: '{min_v}'"
                            else:
                                assert ver[
                                           "naam"] not in verenigingen, f"{id}:{ver['__line__']} unknown '{ver['naam']}'"

                if "antwoorden" in antwoord:
                    self.checkQuiz(antwoord, verenigingen, id)

    def test_checkQuizUsesCorrectId(self):
        verenigingen = self.getIds(self.VERENIGINGEN)
        verenigingen += self.getIds(self.PROJECTEN)

        for quiz in glob.glob(self.QUIZ, recursive=True):
            if quiz[-2:] != "md":
                continue
            header = self.loadHeader(quiz)
            self.checkQuiz(header, verenigingen, quiz)


if __name__ == '__main__':
    unittest.main()
