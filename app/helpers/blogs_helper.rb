module BlogsHelper
    def show_edit_button?
        controller_name == 'dashboard'
    end
end
