#!/usr/bin/env python3
import glob, yaml
from yaml.loader import SafeLoader

from fuzzy import string_dist


class SafeLineLoader(SafeLoader):
    def construct_mapping(self, node, deep=False):
        mapping = super(SafeLineLoader, self).construct_mapping(node, deep=deep)
        # Add 1 so line numbering starts at 1
        mapping['__line__'] = node.start_mark.line + 1
        return mapping


KONVENTEN = "content/konventen/*"
VERENIGINGEN = "./content/verenigingen/*"
PROJECTEN = "content/projecten/*"
QUIZ = "content/quiz/*"


def loadHeader(filename):
    lines = []
    loading = False
    for line in open(filename).readlines():
        if "---" in line:
            if loading:
                return yaml.load("".join(lines), Loader=SafeLineLoader)
            else:
                loading = True
        if loading:
            lines.append(line)


def checkAllSyntax():
    for location in [KONVENTEN, VERENIGINGEN, PROJECTEN, QUIZ]:
        for f in glob.glob(location, recursive=True):
            try:
                loadHeader(f)
            except yaml.parser.ParserError as e:
                print("Yaml error in " + f)
                print(e)


def getIds(location):
    out = []
    for ver in glob.glob(location, recursive=True):
        if ver[-2:] != "md":
            continue
        header = loadHeader(ver)
        if header and "id" in header:
            out.append(header["id"])
        else:
            print("NO ID FOUND " + ver)
    return out


def getVerIds():
    return getIds(VERENIGINGEN)


def checkVerHasExistingKonvent():
    konventen = getIds(KONVENTEN)
    for ver in glob.glob(VERENIGINGEN, recursive=True):
        if ver[-2:] != "md":
            continue
        header = loadHeader(ver)
        if "konvent" in header:
            if header["konvent"] not in konventen:
                print("No existing konvent " + ver)
        else:
            print("NO KONVENT FOUND " + ver)


def fuzzy_closest(x, xs):
    min_v = min(xs, key=lambda y: string_dist(x, y))
    return (min_v, string_dist(x, min_v))


def checkQuiz(header, verenigingen, id):
    if "antwoorden" in header:
        for antwoord in header["antwoorden"]:
            if "verenigingen" in antwoord:
                for ver in antwoord["verenigingen"]:
                    if ver["naam"] not in verenigingen:
                        min_v, dist_v = fuzzy_closest(ver['naam'], verenigingen)
                        if dist_v < 4:
                            print(f"{id}:{ver['__line__']} unknown '{ver['naam']}' did you mean: '{min_v}'")
                        else:
                            print(f"{id}:{ver['__line__']} unknown '{ver['naam']}'")

            if "antwoorden" in antwoord:
                checkQuiz(antwoord, verenigingen, id)


def checkQuizUsesCorrectId():
    verenigingen = getIds(VERENIGINGEN)
    verenigingen += getIds(PROJECTEN)


    for quiz in glob.glob(QUIZ, recursive=True):
        if quiz[-2:] != "md":
            continue
        header = loadHeader(quiz)
        checkQuiz(header, verenigingen, quiz)

for f in [checkAllSyntax, getVerIds, checkVerHasExistingKonvent, checkQuizUsesCorrectId]:
    print("---------------------------- " + f.__name__ + " ----------------------------")
    f()
