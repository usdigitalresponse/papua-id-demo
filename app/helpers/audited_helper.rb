module AuditedHelper
  def enumerize(class_of_item, property, value)
    # If this is an enum and the value is found inside that enum, look it up in I18n by the class name, the property name, and the enum value:
    if(class_of_item.respond_to? property.pluralize) && (enum_value = class_of_item.send(property.pluralize)&.key(value)).present?
      t "#{class_of_item.name.underscore}.#{property.pluralize}.#{enum_value}"
    else
      value
    end
  end
end
