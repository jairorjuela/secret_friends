require "test_helper"

class WorkerTest < ActiveSupport::TestCase
  def setup
    @location = locations(:location_one)
    @worker = workers(:worker_one)
  end

  # DB columns
  test 'name column' do
    assert Worker.column_names.include?('name'), 'name column exist in Worker table'
    assert_equal 'string', worker_type_column('name').type.to_s, 'correctly name type'
    assert_equal false, worker_type_column('name').null, 'require name value'
  end

  # Associations
  test 'belongs_to :location relation' do
    assert_equal @location, @worker.location, 'relation between worker and location'
  end

  test 'has_many :games relation' do
    assert_equal 1, @worker.games.size, 'relation between worker and game'
  end

  # Index
  test 'name indexes' do
    indexes = ::ActiveRecord::Base.connection.indexes(Worker.table_name)
    matched_index = indexes.detect { |each| each.columns == ['location_id'] }

    assert_equal true, matched_index.present?, 'location_id index exist in worker table'
  end

  # Validations
  test 'invalid without name' do
    @worker.name = nil

    refute @worker.valid?
    assert @worker.errors[:name].present?, 'error without name'
  end

  test 'invalid name length' do
    @worker.name = 'Ary'

    refute @worker.valid?
    assert @worker.errors[:name].present?, 'error with too short length name'

    @worker.name = 'A'*50
    refute @worker.valid?
    assert @worker.errors[:name].present?, 'error with too long length name'
  end

  # Methods
  test 'couple_games method' do
    assert_equal 1, @worker.couple_games.size, 'quantity games'
  end

  def worker_type_column(column)
    Worker.columns.detect { |each| each.name == column.to_s }
  end
end
