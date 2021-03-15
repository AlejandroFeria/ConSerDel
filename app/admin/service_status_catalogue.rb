ActiveAdmin.register ServiceStatusCatalogue do
  config.clear_action_items!

  resource_name = "Estatus de servicio"
  resource_title = "Estatus"
  menu label: resource_title, parent: "Configuración", priority: 3


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
        f.input :status_equivalences, label: 'Estatus equivalentes'
      end
      
      f.actions do
        f.action :submit, label: I18n.t("global.save_button")
        f.action :cancel, label: I18n.t("global.cancel_button")
      end
  end
end
