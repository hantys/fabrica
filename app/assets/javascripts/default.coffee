$(document).ready ->
  $('.date').mask '00/00/0000'
  $('.time').mask '00:00:00'
  $('.date_time').mask '00/00/0000 00:00:00'
  $('.cep').mask '00000-000'
  $('.phone').mask '0000-0000'
  $('.phone_with_ddd').mask '(00) 0000-0000'
  $('.phone_us').mask '(000) 000-0000'
  $('.mixed').mask 'AAA 000-S0S'
  $('.cpf').mask '000.000.000-00', reverse: true
  $('.cnpj').mask '00.000.000/0000-00', reverse: true
  $('.money').mask '000.000.000.000.000,00', reverse: true
  $('.money2').mask '#.##0,00', reverse: true
  $('.ip_address').mask '0ZZ.0ZZ.0ZZ.0ZZ', translation: 'Z':
    pattern: /[0-9]/
    optional: true
  $('.ip_address').mask '099.099.099.099'
  $('.percent').mask '##0,00%', reverse: true
  $('.clear-if-not-match').mask '00/00/0000', clearIfNotMatch: true
  $('.placeholder').mask '00/00/0000', placeholder: '__/__/____'
  $('.fallback').mask '00r00r0000', translation:
    'r':
      pattern: /[\/]/
      fallback: '/'
    placeholder: '__/__/____'
  $('.selectonfocus').mask '00/00/0000', selectOnFocus: true

  $('.simple-select2').select2
    theme: 'bootstrap4'
    allowClear: true


  get_cep()


@error_cep = ->
    $('.cep').addClass('error')
    $('.cep').parent().addClass('error')
    $('.cep').after('<small class="error_cep error">cep não encontrado</small></div>')

@clear_cep = ->
  $('.cep').removeClass('error')
  $('.cep').parent().removeClass('error')
  $('.error_cep').remove()

@get_cep = () ->
  $('.cep').keyup ->
    cep = $(this)
    if $(this).val().length == 9
      clear_cep()
      $.get("/busca/endereco/"+$(this).val(), (data) ->
        clear_cep()
        unless data == 0
          $('.neighborhood').val data.bairro
          $('.street').val data.street
          $('.state').val data.state
          $('.city').html ''
          $('.city').append "<option value=\"\">Cidade</option>"
          for city in data.cities
            $('.city').append "<option value='#{city.id}'>#{city.name}</option>"
          $('.city').val data.city

        else
          error_cep
          # $('.cep').val('')
        clear_cep()
      ).fail ->
        if $('.error_cep').length < 1
          error_cep()