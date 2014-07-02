define ['knockout'], (ko) ->
	class Skill
		constructor: ->
			@feedback = ko.observable null
			@skill = ko.observable null
			@isShowingInfo = ko.observable no
			@descriptions = [
				{
					text: '{name} does not contribute with {thirdpersonpossessive} skill or technical ability.'
					startAt: 0
					endAt: 0
				}
				{
					text: '{name} is learning skills and abilities and knows a few techniques.'
					startAfter: 0
					endBefore: 0.1
				}
				{
					text: '{name} is learning skills and abilities and knows the basics to get the job done.'
					startAt: 0.1
					endBefore: 0.2
				}
				{
					text: '{name} is beginning to get a grasp on the rules and principles.'
					startAt: 0.2
					endBefore: 0.3
				}
				{
					text: '{name} understands most of the rules and principles and is beginning to understand when certain rules aren\'t applicable.'
					startAt: 0.3
					endBefore: 0.4
				}
				{
					text: '{name} shows great skill and ability in most situations and understands that in some situations {thirdpersonpossessive} own judgement is needed.'
					startAt: 0.4
					endBefore: 0.5
				}
				{
					text: 'A crafter, {name} is well skilled and engages in new teritories with ease.'
					startAt: 0.5
					endBefore: 0.6
				}
				{
					text: '{name} has great depth of skill and ability and regularily pursues new ideas.'
					startAt: 0.6
					endBefore: 0.7
				}
				{
					text: '{name} follows the latest developments in {thirdpersonpossessive} field, incorporating these advancements into {thirdpersonpossessive} work.'
					startAt: 0.7
					endBefore: 0.8
				}
				{
					text: '{name} develops new ideas and pushes the boundaries of what is possible in {thirdpersonpossessive} field.'
					startAt: 0.8
					endBefore: 0.9
				}
				{
					text: '{name} is well respected in the community for {thirdpersonpossessive} ability and technical excellence.'
					startAt: 0.9
					endBefore: 1
				}
				{
					text: 'At the pinnacle of {thirdpersonpossessive} field, {name} has a PHD or equivalent and likely publishes articles.'
					startAt: 1
					endAt: 1
				}
			]
		
		shouldShow: (range, value) =>
			if (range.startAt? and value < range.startAt) or
					(range.startAfter? and value <= range.startAfter) or
					(range.endAt? and value > range.endAt) or
					(range.endBefore? and value >= range.endBefore)
				return no
			
			return yes
		
		activate: (options) =>
			{ @wizard, activationData } = options
			@feedback activationData
			if @feedback().feedback.skill?
				@skill @feedback().feedback.skill
			else
				@skill 0.05
			
			
			thirdpersonpossessive = 'its'
			thirdpersonpronoun = 'it'
			if @feedback().reviewee.gender is 'male'
				thirdpersonpossessive = 'his'
				thirdpersonpronoun = 'he'
			if @feedback().reviewee.gender is 'female'
				thirdpersonpossessive = 'her'
				thirdpersonpronoun = 'she'
			
			for description in @descriptions
				that = description
				that.text = that.text
					.replace(/\{name\}/g, @feedback().reviewee.short)
					.replace(/\{thirdpersonpossessive\}/g, thirdpersonpossessive)
					.replace(/\{thirdpersonpronoun\}/g, thirdpersonpronoun)
		
		back: =>
			@feedback().feedback.skill = @skill()
			options = {
				model: 'views/feedback/give/0-introduction'
				activationData: @feedback()
			}
			@wizard.back(options)()
		
		forward: =>
			@feedback().feedback.skill = @skill()
			options = {
				model: 'views/feedback/give/2-output'
				activationData: @feedback()
			}
			@wizard.forward(options)()
		
		showInfo: =>
			@isShowingInfo yes
