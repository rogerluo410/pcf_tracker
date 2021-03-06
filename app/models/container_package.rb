class ContainerPackage < ActiveRecord::Base
  attr_accessible :container_id, :deleted, :mt_id, :name, :status, :ut_id, :version

  INITIAL = 0
     DONE = 1
 
  NOT_DELETED = false
      DELETED = true

  STATUS_DESC = {
      INITIAL  => 'Initial product',
         DONE  => 'Package has been finished'
  }

  DELETED_DESC = {
        NOT_DELETED => 'Package is not deleted',
            DELETED => 'Package has been deleted' 
  }

  belongs_to :container, :class_name => 'Container',:foreign_key => 'container_id'

  scope :not_deleted, where(:deleted => NOT_DELETED)
  scope :find_not_deleted,->(id) { where("id = ? and deleted = false ", id)}
  scope :find_by_name, ->(name,version,container_id) { where("name = ? and version = ? and container_id = ? and deleted = false",name,version,container_id) }
  scope :all_notdeleted_by_containerid, ->(container_id) { where("container_id = ? and deleted = false",container_id).order('name,id desc') }
  scope :get_missing_mt,->(container_id) { where("container_id = ? and deleted = false and mt_id = 0 " , container_id) }
  


end
