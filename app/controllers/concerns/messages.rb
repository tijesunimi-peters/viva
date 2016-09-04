module Messages
  def msg(val = nil)
    {
      not_found: "#{val} not found",
      required: "#{val} required",
      error_occured: "Error occured",
      deleted: "#{val} deleted",
      limit_exceeded: "Maximum result per request is 100",
      successful: "#{val} successful",
      login_failed: "Email/Password Incorrect"
    }
  end

  def output_errors(errors)
    if errors.is_a? Array
      errors.map { |item| "#{item}<br>" }.join
    else
      errors
    end
  end
end
