
resource "null_resource" "set_global_sub" {

  provisioner "local-exec" {
    command = "az account set --subscription 2eb45bac-2a47-44fc-844e-81474a62a406"
  }
}

resource "null_resource" "frontend_ui_cname" {

  provisioner "local-exec" {
    command = "az network dns record-set cname set-record -g wcp-gov-wus2-dns-rg -z consitemine.com -n ${var.environmentPrefix}app-consite -c ${var.frontendwebapp_AzureDomain}"
  }
}


resource "null_resource" "apim_ui_cname" {

  provisioner "local-exec" {
    command = "az network dns record-set cname set-record -g wcp-gov-wus2-dns-rg -z consitemine.com -n ${var.environmentPrefix}api-consite -c ${var.apim_name}.azure-api.net"
  }
}