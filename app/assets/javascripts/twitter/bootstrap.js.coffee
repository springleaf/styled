#= require twitter/bootstrap/affix
#= require twitter/bootstrap/alert
#= require twitter/bootstrap/button
#= require twitter/bootstrap/carousel
#= require twitter/bootstrap/collapse
#= require twitter/bootstrap/dropdown
#= require twitter/bootstrap/modal
#= require twitter/bootstrap/tooltip
#= require twitter/bootstrap/popover
#= require twitter/bootstrap/scrollspy
#= require twitter/bootstrap/tab
#= require twitter/bootstrap/transition

jQuery ->
  $("a[rel~=popover], .has-popover").popover()
  $("a[rel~=tooltip], .has-tooltip").tooltip()
