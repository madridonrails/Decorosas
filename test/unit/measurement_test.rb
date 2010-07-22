require 'test_helper'

class MeasurementTest < ActiveSupport::TestCase

  fixtures :measurements

  test 'project must be present ' do
    measurement = measurements(:measurement_one)
    assert measurement.valid?

    measurement.project_id = nil
    assert !measurement.valid?
  end
end
