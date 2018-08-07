$(document).ready ->
  $('.date').mask '00/00/0000'
  $('.cep').mask '00000-000'
  $('.phone_with_ddd').mask '(00) 00000-0000'
  $('.cpf').mask '000.000.000-00', reverse: true
  $('.cnpj').mask '00.000.000/0000-00', reverse: true
  $('.money').mask '000.000.000.000.000,00', reverse: true
  $('.money2').mask '#.##0,00', reverse: true

  $('#show_object').on 'show.bs.modal', (event) ->
    button = $(event.relatedTarget)
    # Button that triggered the modal
    link = button.data('link')

    modal = $(this)

    $.get link, {modal: 'true'}, ((data) ->
      modal.find('.modal-body').html(data)
    ), 'html'

  $('.simple-select2').select2
    theme: 'bootstrap4'
    allowClear: true

  $('.multi-select2').select2
    theme: 'bootstrap4'
    allowClear: true
    multiple: true
    placeholder: "Selecione"

  if $('.state').length > 0
    $('.state').change ->
      $.get("/busca/cidades/#{$(this).val()}", (data) ->
        $('.city').html ''
        $('.city').append "<option value=\"\">Cidade</option>"
        for city in data
          $('.city').append "<option value='#{city.id}'>#{city.name}</option>"
        $('.city').val data.city
      ).done(->
        console.log 'second success'
      ).fail(->
        console.log 'error'
      ).always(->
        console.log 'finished'
      )
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