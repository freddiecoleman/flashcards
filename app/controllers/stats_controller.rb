class StatsController < ApplicationController
	before_filter :authorise
	def index
		flashcards = @current_user.flashcards.all
		new_count = @current_user.flashcards.where("interval < 1").count
		young_count = @current_user.flashcards.where("interval < 6 AND interval >= 1").count
		mature_count = @current_user.flashcards.where("interval >= 6").count
		total_count = new_count+young_count+mature_count


    testdays = (6.days.ago.to_date..Date.today).map { |date| date.strftime("%b %d") }

    easy_log = (6.days.ago.to_date..Date.today).map { |date| @current_user.review_logs.where("date = ? AND score = 3", date.strftime("%Y-%m-%d 00:00:00")).count }

    # NEED TO MAKE THE DATE in the COMPARISON from within the MODEL to change so that it doesnt include MINUTES AND SECONDS ETC

    # counting easys for a given day
    easy_count = @current_user.review_logs.where("date >= ? AND score = 3", Date.today.strftime("%Y-%m-%d")).count
    # counting goods for a given day
    good_count = @current_user.review_logs.where("date >= ? AND score = 2", Date.today.strftime("%Y-%m-%d")).count
    # counting hards for a given day
    hard_count = @current_user.review_logs.where("date >= ? AND score = 1", Date.today.strftime("%Y-%m-%d")).count
    # counting agains for a given day
    again_count = @current_user.review_logs.where("date >= ? AND score = 0", Date.today.strftime("%Y-%m-%d")).count

    #@wot = @current_user.review_logs.where("date = ? AND score = 3", Date.today.strftime("%Y-%m-%d")).count
    @wot = @current_user.review_logs.where("score = 3").map { |var| var.date.strftime("%Y-%m-%d") }
    #.map { |var| var.date.strftime("%b %d") }
    #@wot = @current_user.review_logs.sum(:score)
    #@wot = Date.today.strftime("%Y-%m-%d 00:00:00")
    #need 2014-05-06

		@chart1 = LazyHighCharts::HighChart.new('graph') do |f|
		    f.title({ :text=>"Flashcard Statistics"})
		    f.options[:xAxis][:categories] = testdays
		    f.labels(:items=>[:html=>"Flashcard Status", :style=>{:left=>"40px", :top=>"8px", :color=>"black"} ])      
		    f.series(:type=> 'column',:name=> 'Easy Count',:data=> easy_log)
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
