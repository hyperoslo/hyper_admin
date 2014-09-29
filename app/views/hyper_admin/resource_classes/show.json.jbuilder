def infer_type_from_attribute(resource_class, attribute)
  attribute = attribute.to_s

  resource_class.columns_hash[attribute].type
end

real_resource = @resource_class.resource_class

json.menu_label real_resource.model_name.human(count: 2)
json.singular real_resource.model_name.singular
json.singular_human real_resource.model_name.human(count: 1)
json.plural real_resource.model_name.plural
json.plural_human real_resource.model_name.human(count: 2)

show_attributes = if @resource_class.show_config
                    @resource_class.show_config.each.map do |config|
                      {
                        key: config[:attribute],
                        human: config[:human],
                        type: config[:type]
                      }
                    end
                  else
                    real_resource.attribute_names.map do |attr|
                      {
                        key: attr,
                        human: real_resource.human_attribute_name(attr),
                        type: infer_type_from_attribute(real_resource, attr)
                      }
                    end
                  end

index_attributes = if @resource_class.index_config
                     @resource_class.index_config.each.map do |config|
                       {
                         key: config[:attribute],
                         human: config[:human],
                         type: config[:type]
                       }
                     end
                   else
                     real_resource.attribute_names.map do |attr|
                       {
                         key: attr,
                         human: real_resource.human_attribute_name(attr),
                         type: infer_type_from_attribute(real_resource, attr)
                       }
                     end
                   end

form_attributes = if @resource_class.form_config
                     @resource_class.form_config.each.map do |config|
                       {
                         key: config[:attribute],
                         human: config[:human],
                         type: config[:type]
                       }
                     end
                   else
                     real_resource.attribute_names.map do |attr|
                       {
                         key: attr,
                         human: real_resource.human_attribute_name(attr),
                         type: infer_type_from_attribute(real_resource, attr)
                       }
                     end
                   end

json.show_attributes show_attributes
json.index_attributes index_attributes
json.form_attributes form_attributes
