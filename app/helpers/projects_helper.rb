module ProjectsHelper

  def get_project(field_name)
    project_hash = {:project => field_name}
    if (@query_project == field_name)
      project_hash[:direction] = (@direction == 'asc' ? 'desc' : 'asc')
    else
      project_hash[:direction] = 'asc'
    end
    return project_hash
  end

  def links_to_transitions(project)
    links = []
    project.aasm_events_for_current_state.each do |event|
      links << link_to(t("project.events.#{event.to_s}.title"), :action => event.to_s, :id => project.id, :page => params[:page]) if transitions_are_valid?(event, project)
    end
    links.join(' | ')
  end

  private
  
  def transitions_are_valid?(event, project)
    if is_current_shop?(project.shop) || is_admin?
      automatic_transitions = [:measure, :accept]
      hidden_transitions = [:back_to_estimated]
      only_for_admin_transitions = [:complete]
      !automatic_transitions.include?(event) and (is_admin? || !only_for_admin_transitions.include?(event)) and !hidden_transitions.include?(event)
    elsif is_central?
      allowed_transitions = [:receive]
      hidden_transitions = [:back_to_estimated]
      allowed_transitions.include?(event) and !hidden_transitions.include?(event)
    end
  end

end
