

process sayHello {
  output:
    stdout

  """
  hello --say-ni --verbose
  """
}


workflow {
  sayHello | view { it.trim() }
}

