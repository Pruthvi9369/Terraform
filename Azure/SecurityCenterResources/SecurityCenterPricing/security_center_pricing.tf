resource "azurerm_security_center_subscription_pricing" "security_center_pricing" {
  tier = "${var.security_center_pricing_tier}"
}
