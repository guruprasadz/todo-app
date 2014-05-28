# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$.fn.extend {   
	integrateDatepicker: (selector)->     
	  selector = selector || '.datepicker'     
	  $(@).find(selector).datepicker({format: 'dd/mm/yyyy'})
	  selector1 = selector1 || '#datetimepicker'     
	  $(@).find(selector1).datetimepicker()

	
	  

	
}
$.fn.extend {   
	integrateDateTimepicker: (selector)-> 
	  selector = selector || '#datetimepicker'     
	  $(@).find(selector).datetimepicker()
}
$(document).ready () -> 
  $('body').integrateDatepicker()
  $('body').integrateDateTimepicker() 
       

   