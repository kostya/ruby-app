class Model

  def raised_method
    ErrorMailer.safe do
      raise "hah"
    end
  end

end