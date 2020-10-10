Given('Um usuario administrador existe') do
  Usuario.create(nome: 'admin', email: 'admin@example.com', telefone: '8799999999', data_nascimento: Date.new(1999, 9, 9), password: 'password', password_confirmation: 'password', tipo: 2)
end

And('Eu estou logado como administrador com email {string} e senha {string}') do |email, senha|
  visit "/sign_in"
  fill_in 'session[email]', :with => email
  fill_in 'session[password]', :with => senha
  click_button 'Entrar'
  expect(page).to have_content('Admin')
end

And('Eu estou na pagina de exercicios') do
  visit '/exercicios'
  expect(page).to have_current_path('/exercicios')
end

And('Eu clico no botao novo exercicio') do
  click_link 'Novo Exercicio'
  expect(page).to have_current_path('/exercicios/new')
end

When('Eu preencho o nome do exercico com {string} com grupo muscular {string} e descricao {string}') do |nome, gp_muscular, descricao|
  fill_in 'exercicio[nome]', :with => nome
  fill_in 'exercicio[grupo_muscular]', :with => gp_muscular
  fill_in 'exercicio[descricao]', :with => descricao
  click_button 'commit'
end

Then('Eu vejo que o exercicio de titulo {string} foi criado com sucesso') do |titulo|
  expect(page).to have_content(titulo)
  click_link 'Voltar'
end

And ('O exercicio de titulo {string}, grupo muscular {string} e descricao {string} existe') do |titulo, gp_muscular, descricao|
  visit '/exercicios/new'
  expect(page).to have_current_path('/exercicios/new')
  fill_in 'exercicio[nome]', :with => titulo
  fill_in 'exercicio[grupo_muscular]', :with => gp_muscular
  fill_in 'exercicio[descricao]', :with => descricao
  click_button 'commit'
  expect(page).to have_content(titulo)
  click_link 'Voltar'
end

When ('Eu clico em excluir exercicio de titulo {string}') do |titulo|
  click_link "d-#{titulo}"
end

Then ('Eu vejo uma mensagem {string}') do |mensagem|
  expect(page).to have_content(mensagem)
end

When ('Eu deixo os campos nome vazio {string}, grupo muscular {string} e descricao {string}') do |vazio1, gp_muscular, descricao|
  fill_in 'exercicio[nome]', :with => vazio1
  fill_in 'exercicio[grupo_muscular]', :with => gp_muscular
  fill_in 'exercicio[descricao]', :with => descricao
  click_button 'commit'
end

Then ('Eu vejo uma mensagem de exercicio invalido') do
  assert_selector('div#error_explanation')
end

And ('O exercicio de nome {string} existe') do |titulo|
  visit '/exercicios/new'
  expect(page).to have_current_path('/exercicios/new')
  fill_in 'exercicio[nome]', :with => titulo
  fill_in 'exercicio[grupo_muscular]', :with => 'abdomen'
  fill_in 'exercicio[descricao]', :with => 'description'
  click_button 'commit'
end

And ('Eu estou na pagina para editar o exercicio') do
  click_link 'Editar'
  expect(page).to have_content('Editando Exercicio')
end

When ('Eu renomeio a descricao com {string} e clico no botao de update exercicio') do |descricao|
  fill_in 'exercicio[descricao]', :with => descricao
  click_button 'commit'
end

Then ('Eu vejo uma mensagem de {string}') do |mensagem|
  expect(page).to have_content(mensagem)
end

Then ('Eu vejo uma mensagem de erro') do
  assert_selector('div#error_explanation')
end