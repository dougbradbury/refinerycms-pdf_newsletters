module PdfNewslettersHelper
  def newsletter_description(newsletter)
    "Volume #{newsletter.volume} Issue #{newsletter.issue} - #{newsletter.month} #{newsletter.year}"
  end

  def each_year(newsletters)
    newsletters_list = newsletters
    newsletter = newsletters_list.shift
    while newsletter.present?
      year_list = []
      @year = newsletter.year
      while newsletter && newsletter.year == @year
        year_list << newsletter
        newsletter = newsletters_list.shift
      end
      yield year_list
    end
  end
end
