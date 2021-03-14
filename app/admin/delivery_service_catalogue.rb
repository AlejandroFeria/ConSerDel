ActiveAdmin.register DeliveryServiceCatalogue do
  config.clear_action_items!

  resource_name = "Catalogo de paqueterias"
  resource_title = "Catalogo de paqueterias"
  menu label: resource_title, parent: "Configuración", priority: 1
  permit_params :name, :var_name, :description, delivery_service_auth_keys_attributes: [:id, :name, :var_name]

  before_action { @page_title = I18n.t("active_admin.new_model", model: resource_name) }

  action_item :view do
    link_to(I18n.t('global.action_items.new', resource: resource_name), new_resource_path)
  end

  action_item :view, only: :show do
    link_to(I18n.t('global.action_items.edit', resource: resource_name), edit_resource_path)
  end

  action_item :view, only: [:show, :edit] do
    link_to(I18n.t('global.action_items.delete', resource: resource_name), { action: :destroy }, method: :delete, data: { confirm: I18n.t("active_admin.delete_confirmation") })
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
      f.inputs resource_name.titleize do
        f.input :name, label: 'Nombre'
        f.input :var_name
        f.input :description, label: 'Descripcion'
      end
      f.inputs "Configuración de llaves de acceso".upcase do
        f.has_many :delivery_service_auth_keys, heading: false, allow_destroy: true do |dsak|
          dsak.input :name, label: "nombre"
          dsak.input :var_name, label: 'llave'
        end
      end

      f.actions do
        f.action :submit, label: I18n.t("global.save_button")
        f.action :cancel, label: I18n.t("global.cancel_button")
      end
  end
end
