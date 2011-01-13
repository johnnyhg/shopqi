class TasksObserver < ActiveRecord::Observer
  observe :order

  def after_update(rec)
    publish(rec)
  end

  protected
  def publish(rec)
    Juggernaut.publish "tasks/#{rec.id}", {:id => rec.view_id, :name => rec.number}
  end
end
