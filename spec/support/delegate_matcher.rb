# RSpec matcher to spec delegations.
# Gist Version https://gist.github.com/joeytheman/0fe021821e4c62f552ce
#
#
# Usage:
#
#     describe Post do
#       it { should delegate(:name).to(:author).with_prefix } # post.author_name
#       it { should delegate(:name).to(:author).with_prefix(:any) } # post.any_name
#       it { should delegate(:month).to(:created_at) }
#       it { should delegate(:year).to(:created_at) }
#       it { should delegate(:something).to(:'@instance_var') }
#     end

RSpec::Matchers.define :delegate do |method|
  match do |delegator|
    @method = @prefix ? :"#{@prefix}_#{method}" : method
    @delegator = delegator

    if @to.to_s[0] == '@'
      # Delegation to an instance variable
      old_value = @delegator.instance_variable_get(@to)
      begin
        @delegator.instance_variable_set(@to, receiver_double(method))
        @delegator.send(@method) == :called
      ensure
        @delegator.instance_variable_set(@to, old_value)
      end
    elsif @delegator.respond_to?(@to, true)
      unless [0,-1].include?(@delegator.method(@to).arity)
        raise "#{@delegator}'s' #{@to} method does not have zero or -1 arity (it expects parameters)"
      end
      allow(@delegator).to receive(@to).and_return(receiver_double(method))
      @delegator.send(@method) == :called
    else
      raise "#{@delegator} does not respond to #{@to}"
    end
  end

  description do
    "delegate :#{@method} to its #{@to}#{@prefix ? ' with prefix' : ''}"
  end

  failure_message do |text|
    "expected #{@delegator} to delegate :#{@method} to its #{@to}#{@prefix ? ' with prefix' : ''}"
  end

  failure_message_when_negated do |text|
    "expected #{@delegator} not to delegate :#{@method} to its #{@to}#{@prefix ? ' with prefix' : ''}"
  end

  chain(:to) { |receiver| @to = receiver }
  chain(:with_prefix) { |*prefix| @prefix = prefix.first || @to }

  def receiver_double(method)
    double('receiver').tap do |receiver|
      allow(receiver).to receive(method).and_return(:called)
    end
  end
end