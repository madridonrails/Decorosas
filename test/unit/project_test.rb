require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  fixtures :projects

  test 'client_id must be present' do
    project = projects(:project_one)
    assert project.valid?

    project.client_id = nil
    assert !project.valid?
  end

  test 'shop_id must be present' do
    project = projects(:project_one)
    assert project.valid?

    project.shop_id = nil
    assert !project.valid?
  end

  test 'address must be present' do
    project = projects(:project_one)
    assert project.valid?

    project.address = nil
    assert !project.valid?
    
    project.address = ''
    assert !project.valid?
  end

  test 'code must be present' do
    project = projects(:project_one)
    assert project.valid?

    project.code = nil
    assert !project.valid?
    
    project.code = ''
    assert !project.valid?
  end

end
