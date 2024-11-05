module EventsHelper
  def create_link_for(role)
    links = { name: 'Create New Event', path: new_event_path, class: 'btn btn--primary event__new' }
    links if role == 'admin'
  end

  def action_links_for(event, role)
    links = default_action_links(event)
    reject_links_based_on_role(links, role)
  end

  def default_action_links(event)
    [
      { name: 'edit', path: edit_event_path(event), class: 'btn btn--primary' },
      { name: 'delete', path: event_path(event), method: :delete, data: { turbo_confirm: 'Are you sure?' },
        class: 'btn btn--danger' },
      { name: 'archive', path: archive_event_path(event), method: :put, data: { confirm: 'Are you sure?' },
        class: 'btn btn--secondary' }
    ]
  end

  def reject_links_based_on_role(links, role)
    links_to_reject = case role
                      when 'admin'
                        [] # Admins see all actions
                      else
                        %w[edit delete archive] # Non-admins don't see these
                      end
    links.reject { |link| links_to_reject.include?(link[:name]) }
  end
end
