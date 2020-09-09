module AuditedHelper
  def t_enum(class_of_item, property, value)
    # If this is an enum and the value is found inside that enum, look it up in I18n by the class name, the property name, and the enum value:
    #   t_enum(PersonType, "favorite_doughnut", "old_fashioned")
    # returns the I18n string:
    #   t "person_type.favorite_doughnuts.old_fashioned"
    # if and only if favorite_doughnut is an enum on the PersonType model - otherwise just returns the raw value.
    if(class_of_item.respond_to? property.pluralize) && (enum_value = class_of_item.send(property.pluralize)&.key(value)).present?
      t "#{class_of_item.name.underscore}.#{property.pluralize}.#{enum_value}"
    else
      value
    end
  end
end
