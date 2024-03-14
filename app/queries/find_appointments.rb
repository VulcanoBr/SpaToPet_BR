class FindAppointments
  attr_reader :appointments

  def initialize(appointments = initial_scope)
    @appointments = appointments
  end

  def call(params = {})
    scoped = appointments
    scoped = filter_by_query_text(scoped, params[:query_text])
    scoped = filter_by_status(scoped, params[:status])
    sort(scoped, params[:order_by])
  end

  private

  def initial_scope
    Appointment.order(created_at: :desc)
  end

  def filter_by_query_text(scoped, query_text)
    return scoped unless query_text.present?

    scoped.search_full_text(query_text)
  end

  def filter_by_status(scoped, status)
    return scoped unless status.present?

    scoped.where(status: status)
  end

  def sort(scoped, order_by)
    order_by_query = Appointment::ORDER_BY.fetch(order_by&.to_sym, Appointment::ORDER_BY[:newest])
    scoped.order(order_by_query)
  end

end