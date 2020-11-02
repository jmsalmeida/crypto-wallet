module ApplicationHelper
  def rails_env
    if Rails.env.development?
      'Desenvolvimento'
    elsif Rails.env.production?
      'Produção'
    else
      'Teste'
    end
  end
end
