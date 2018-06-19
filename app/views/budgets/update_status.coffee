$("#budget-item-<%= @budget.id %>").html("<%= escape_javascript(render partial: 'budgets_item', locals: {:'budget' => @budget}) %>")
