class Approved
  def prepare(ship_qty)
    update_attributes(:ship_qty => ship_qty)
  end
end