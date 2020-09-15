window.addEventListener('load', function() {
  let options = document.getElementsByClassName('randomVerenigingWrapper');
  let selected = Array.from(options).map(x => ({ x, r: Math.random() + -0.5 * x.hasAttribute('data-iszeus')}))
   .sort((a, b) => a.r - b.r)
   .map(a => a.x)
   .slice(0, 3)
   .map(x => ({ x, r: Math.random()}))
   .sort((a, b) => a.r - b.r)
   .map(a => a.x);

  let destination = document.getElementById("display_repo");
  for (node of selected) {
    node.getElementsByTagName("img")[0].setAttribute("loading", "eager");
    destination.appendChild(node);
  }
});