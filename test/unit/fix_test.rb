require 'test_helper'

class FixTest < ActiveSupport::TestCase

  fixtures :fixes

  test 'project must be present' do
    fix = fixes(:fix_one)
    assert fix.valid?

    fix.project_id = nil
    assert !fix.valid?
  end

  test 'description must be present' do
    fix = fixes(:fix_one)
    assert fix.valid?

    fix.description = nil
    assert !fix.valid?

    fix.description = ''
    assert !fix.valid?
  end
end
