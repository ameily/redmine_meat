module Meat
    module Hooks
        class IssueObserver < ActiveRecord::Observer
            observe :issue
            helper MeatHelper
            
            private base_json(issue)
                auth_url = auth_name = nil
                proj = issue.project

                if issue.author
                    auth_url = url_for(:controller => 'users', :action => 'show', :id => issue.author.id)
                    auth_name = issue.author.name #TODO firstname / lastname
                else
                    auth_url = nil
                    auth_name = "Anonymous"
                end

                {
                    :issue_id => issue.id,
                    :project_name => proj.name,
                    :project_url => url_for(:controller => 'projects', :action => 'show', :id => proj.id),
                    :title => issue.subject,
                    :author_name => auth_name,
                    :author_url => auth_url,
                    :issue_url => url_for(:controller => 'issues', action => 'show', :id => issue.id)
                }
            end

            def after_create(issue)
                obj = @base_json(issue)
                obj[:id] = 'redmine.issue.create'
                push_meat('/push', obj)
            end

            def after_destroy(issue)
            end
        end
    end
end
