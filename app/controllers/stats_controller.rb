class StatsController < ApplicationController
	before_filter :authorise
	def index
		flashcards = @current_user.flashcards.all
		new_count = @current_user.flashcards.where("interval < 1").count
		young_count = @current_user.flashcards.where("interval < 6 AND interval >= 1").count
		mature_count = @current_user.flashcards.where("interval >= 6").count
		total_count = new_count+young_count+mature_count


    testdays = (6.days.ago.to_date..Date.today).map { |date| date.strftime("%b %d") }

    easy_log = (6.days.ago.to_date..Date.today).map { |date| @current_user.review_logs.where("date = ? AND score = 3", date).count }
    good_log = (6.days.ago.to_date..Date.today).map { |date| @current_user.review_logs.where("date = ? AND score = 2", date).count }
    hard_log = (6.days.ago.to_date..Date.today).map { |date| @current_user.review_logs.where("date = ? AND score = 1", date).count }
    again_log = (6.days.ago.to_date..Date.today).map { |date| @current_user.review_logs.where("date = ? AND score = 0", date).count }

		@chart1 = LazyHighCharts::HighChart.new('graph') do |f|
		    f.title({ :text=>"Flashcard Statistics"})
		    f.options[:xAxis][:categories] = testdays
		    f.labels(:items=>[:html=>"Flashcard Status", :style=>{:left=>"40px", :top=>"8px", :color=>"black"} ])      
		    f.series(:type=> 'column',:name=> 'Easy',:data=> easy_log)
        f.series(:type=> 'column',:name=> 'Good',:data=> good_log)
        f.series(:type=> 'column',:name=> 'Hard',:data=> hard_log)
        f.series(:type=> 'column',:name=> 'Again',:data=> again_log)
		    f.series(:type=> 'pie',:name=> 'Flashcard Status', 
		      :data=> [
		        {:name=> 'New', :y=> new_count, :color=> 'red'}, 
		        {:name=> 'Young', :y=> young_count,:color=> 'green'},
		        {:name=> 'Mature', :y=> mature_count,:color=> 'blue'}
		      ],
		      :center=> [100, 80], :size=> 100, :showInLegend=> false)
		end
	end
end
