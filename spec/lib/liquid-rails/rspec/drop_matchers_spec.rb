# frozen_string_literal: true

require 'spec_helper'

describe ProfileDrop, type: :drop do
  include Liquid::Rails::Rspec::DropMatchers

  it { is_expected.to have_attribute(:name) }
  it { is_expected.to have_attribute(:description) }
  it { is_expected.not_to have_attribute(:not_found) }
end

describe PostDrop, type: :drop do
  include Liquid::Rails::Rspec::DropMatchers

  it { is_expected.to have_many(:comments) }
  it { is_expected.not_to have_many(:not_found) }

  it { is_expected.to have_many(:recomments).class_name('CommentsDrop') }
  it { is_expected.to have_many(:recomments).with('ReCommentDrop') }
  it { is_expected.to have_many(:recomments).class_name('CommentsDrop').with('ReCommentDrop') }

  it { is_expected.not_to have_many(:recomments).class_name('NotFound') }
  it { is_expected.not_to have_many(:recomments).with('NotFound') }
  it { is_expected.not_to have_many(:recomments).class_name('NotFound').with('NotFound') }
end

describe CommentDrop, type: :drop do
  include Liquid::Rails::Rspec::DropMatchers

  it { is_expected.to belongs_to(:post) }
  it { is_expected.not_to belongs_to(:not_found) }

  it { is_expected.to belongs_to(:repost).class_name('RePostDrop') }
  it { is_expected.not_to belongs_to(:repost).class_name('NotFound') }
end
