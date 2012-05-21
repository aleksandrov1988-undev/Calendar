$.fn.sum = (attr)->
  sum=0
  $(this).each ->
    sum+=parseInt($(this).attr(attr))
  sum

$ ->
  $(".event-form").submit ->
    $("#event_mask").val($(".btn-mask.active").sum('data-value'))
    true

  $(".mode-radio").change ->
    if $(this).attr('data-force')=='1'
      $(this).removeAttr('data-force')
    else
      $(".btn-mask").removeClass('active')
    if $(this).val()=='1'
      $(".mask-row").show()

      $(".btn-mask:not([data-label1])").hide()
      $(".btn-mask[data-label1]").show().each ->
        $(this).html($(this).attr('data-label1'))
    else if $(this).val()=='2'
      $(".mask-row").show()
      $(".btn-mask").show().each ->
        $(this).html($(this).attr('data-label2'))
    else
      $(".mask-row").hide()
  $(".mode-radio:checked").change()


