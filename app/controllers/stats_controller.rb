class StatsController < ApplicationController
	before_filter :authorise
	def index
		flashcards = @current_user.flashcards.all
		new_count = @current_user.flashcards.where("interval < 1").count
		young_count = @current_user.flashcards.where("interval < 6 AND interval >= 1").count
		mature_count = @current_user.flashcards.where("interval >= 6").count
		total_count = new_count+young_count+mature_count

		@chart1 = LazyHighCharts::HighChart.new('graph') do |f|
		    f.title({ :text=>"Flashcard Statistics"})
		    f.options[:xAxis][:categories] = ['Apples', 'Oranges', 'Pears', 'Bananas', 'Plums']
		    f.labels(:items=>[:html=>"Flashcard Status", :style=>{:left=>"40px", :top=>"8px", :color=>"black"} ])      
		    f.series(:type=> 'column',:name=> 'Jane',:data=> [3, 2, 1, 3, 4])
		    f.series(:type=> 'column',:name=> 'John',:data=> [2, 3, 5, 7, 6])
		    f.series(:type=> 'column', :name=> 'Joe',:data=> [4, 3, 3, 9, 0])
		    f.series(:type=> 'spline',:name=> 'Average', :data=> [3, 2.67, 3, 6.33, 3.33])
		    f.series(:type=> 'pie',:name=> 'Total consumption', 
		      :data=> [
		        {:name=> 'New', :y=> new_count, :color=> 'red'}, 
		        {:name=> 'Young', :y=> young_count,:color=> 'green'},
		        {:name=> 'Mature', :y=> mature_count,:color=> 'blue'}
		      ],
		      :center=> [100, 80], :size=> 100, :showInLegend=> false)
		end
	end
end
