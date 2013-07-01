require 'spec_helper'

describe Cinch::Plugins::Seen do

  include Cinch::Test

  before(:each) do
    @bot = make_bot(Cinch::Plugins::Seen, { :filename => '/dev/null' })
  end

  it 'should allow users to see when users were last active' do
    get_replies(make_message(@bot, 'hello, world!', { :nick => 'foo', :channel => '#bar' }))
    sleep 1 # time-lord hack
    msg = make_message(@bot, '!seen foo', { :nick => 'baz', :channel => '#bar' })
    get_replies(msg).last.
      should match(/baz: I last saw foo \d seconds? ago/)
  end

  it 'should not respond to a users seen request for themselves' do
    msg = make_message(@bot, '!seen foo', { :nick => 'foo', :channel => '#bar' })
    get_replies(msg).
      should be_empty
  end

  it 'should inform users when a person has not been seen before' do
    msg = make_message(@bot, '!seen foo', { :channel => '#bar' })
    get_replies(msg).first.
      should == "test: I've never seen foo before, sorry!"
  end

  it 'should not let people make dumb jokes (or look for multiple people in one seen)' do
    get_replies(make_message(@bot, '!seen your mom today', { :channel => '#bar' })).
      should be_empty
    get_replies(make_message(@bot, '!seen archer pam lana', { :channel => '#bar' })).
      should be_empty
  end
end
