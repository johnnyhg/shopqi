# encoding: utf-8
module AddressHelper
  def region
    "#{District.get(province)}#{District.get(city)}#{District.get(district)}"
  end

  def telephone
    [mobile, phone].reject{|n| n.blank?}.join(',')
  end

  def address_info
    "#{name}(#{telephone}) #{region}#{detail} #{zipcode}"
  end
end
