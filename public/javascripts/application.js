// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function update_code(){
  code_field = document.getElementById('project_code');
  address_field = document.getElementById('project_address');
  shop_field = document.getElementById('project_shop_id');

  address = address_field.value;
  shop_name = shop_field.options[shop_field.selectedIndex].text;
  new_code_field_value = address_field.value.substring(address_field.value.indexOf('/'), address_field.value.length);

  code_field.value = shop_name + '/' + address;
}

function update_address(){
  address_field = document.getElementById('project_address');
  client_field = document.getElementById('project_client_id');
  client_text = client_field.options[client_field.selectedIndex].text;
  client_address = client_text.substring(0, client_text.lastIndexOf('/')-1);
  address_field.value = client_address;
  update_code();
}