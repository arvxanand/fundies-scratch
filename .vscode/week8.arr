use context dcic2024

data TaxonomyTree:
  node(rank :: String, name :: String, children :: List<TaxonomyTree>)
end

lion = node("Species", "Panthera leo", [list: ])
tiger = node("Species", "Panthera tigris", [list: ])
leopard = node("Species", "Panthera pardus", [list: ])
panthera = node("Genus", "Panthera", [list: lion, tiger, leopard])

house-cat = node("Species", "Felis catus", [list: ])
wildcat = node("Species", "Felis silvestris", [list: ])
felis = node("Genus", "Felis", [list: house-cat, wildcat])

felidae = node("Family", "Felidae", [list: panthera, felis])

#Excercise 1
fun count-species(t :: TaxonomyTree) -> Number:
  doc: "Counts the number of nodes with rank 'Species' in the tree"
  if t.rank == "Species":
    1 + count-species-children(t.children)
  else:
    count-species-children(t.children)
  end
where:
  count-species(lion) is 1
  count-species(panthera) is 3
  count-species(felis) is 2
  count-species(felidae) is 5
end

fun count-species-children(c :: List<TaxonomyTree>) -> Number:
  doc: "Helper function to count species in a list of trees"
  cases (List) c:
    | empty => 0
    | link(first, rest) =>
      count-species(first) + count-species-children(rest)
  end
end




fun count-rank(t :: TaxonomyTree, rank :: String) -> Number:
  doc: "Counts the number of nodes with the specified rank in the tree"
  if t.rank == rank:
    1 + count-rank-children(t.children, rank)
  else:
    count-rank-children(t.children, rank)
  end
where:
  count-rank(lion, "Species") is 1
  count-rank(panthera, "Species") is 3
  count-rank(panthera, "Genus") is 1
  count-rank(felidae, "Species") is 5
  count-rank(felidae, "Genus") is 2
  count-rank(felidae, "Family") is 1
end

fun count-rank-children(c :: List<TaxonomyTree>, rank :: String) -> Number:
  doc: "Helper function to count nodes with specified rank in a list of trees"
  cases (List) c:
    | empty => 0
    | link(first, rest) =>
      count-rank(first, rank) + count-rank-children(rest, rank)
  end
end





fun taxon-height(t :: TaxonomyTree) -> Number:
  doc: "Returns the height of the tree (number of levels, root is level 1)"
  1 + taxon-height-children(t.children)
where:
  taxon-height(lion) is 1
  taxon-height(panthera) is 2
  taxon-height(felis) is 2
  taxon-height(felidae) is 3
end

fun taxon-height-children(c :: List<TaxonomyTree>) -> Number:
  doc: "Helper function to find maximum height among list of children"
  cases (List) c:
    | empty => 0
    | link(first, rest) =>
      num-max(taxon-height(first), taxon-height-children(rest))
  end
end





fun all-names(t :: TaxonomyTree) -> List<String>:
  doc: "Returns a list of all names in the tree"
  [list: t.name].append(all-names-list(t.children))
where:
  all-names(lion) is [list: "Panthera leo"]
  all-names(panthera) is [list: "Panthera", "Panthera leo", "Panthera tigris", "Panthera pardus"]
  all-names(felis) is [list: "Felis", "Felis catus", "Felis silvestris"]
  all-names(felidae) is [list: "Felidae", "Panthera", "Panthera leo", "Panthera tigris", "Panthera pardus", "Felis", "Felis catus", "Felis silvestris"]
end

fun all-names-list(c :: List<TaxonomyTree>) -> List<String>:
  doc: "Helper function to get all names from a list of trees"
  cases (List) c:
    | empty => [list: ]
    | link(first, rest) =>
      all-names(first).append(all-names-list(rest))
  end
end
