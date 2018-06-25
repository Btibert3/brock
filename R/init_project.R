#' Initialize a project structure within the current directory
#'
#' This function will initialize a project structure within the current
#' directory.  This includes files and directories for an arbitrary
#' data science project.  More than likely, not all are needed, but
#' remove as necessary.  If the directory or file exists, it will not
#' be modified.
#' @export
#' @examples
#' init_project()

init_project = function () {
  ## create folders, will not overwrite if it exists
  dir.create("R", showWarnings = FALSE)
  dir.create("sql", showWarnings = FALSE)
  dir.create("soql", showWarnings = FALSE)
  dir.create("cql", showWarnings = FALSE)
  dir.create("data", showWarnings = FALSE)
  dir.create("raw", showWarnings = FALSE)
  dir.create("tmp", showWarnings = FALSE)
  dir.create("figs", showWarnings = FALSE)
  ## create the README and populate with a skeleton structure
  if(!file.exists("README.md")) {
    system("touch README.md")
    system("echo '# TITLE_HERE\n\n## About\n\n## Requirements' >> README.md")
  }
  ## create the gitignore file if it doesnt exist
  if(!file.exists(".gitignore")) {
    file.create(".gitignore")
  }
  
  
}

