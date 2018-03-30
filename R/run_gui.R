#'Run a Graphical User Interface (GUI) for BDVis
#'
#' @author Boyan Angelov
#'
#' @description This function starts a browser based application that exposes the major functions of the package.
#'
#' @examples
#' run_gui()
#' 
#' @export run_gui
run_gui <- function(){
  app_path <- system.file("shiny", package = "bdvis")
  return(shiny::runApp(app_path, launch.browser = TRUE))
}