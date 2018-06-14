$(document).ready ->
  $('.date').mask '00/00/0000'
  $('.cep').mask '00000-000'
  $('.phone_with_ddd').mask '(00) 00000-0000'
  $('.cpf').mask '000.000.000-00', reverse: true
  $('.cnpj').mask '00.000.000/0000-00', reverse: true
  $('.money').mask '000.000.000.000.000,00', reverse: true
  $('.money2').mask '#.##0,00', reverse: true

  $('.simple-select2').select2
    theme: 'bootstrap4'
    allowClear: true

  if $('.cep').length > 0
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