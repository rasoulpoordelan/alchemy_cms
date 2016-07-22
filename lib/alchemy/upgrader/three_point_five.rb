require_relative 'tasks/install_dragonfly_config'

module Alchemy
  module Upgrader::ThreePointFive
    private

    def install_dragonfly_config
      desc 'Install dragonfly config into `config/initializers`'
      Alchemy::Upgrader::Tasks::InstallDragonflyConfig.new.install
    end

    def alchemy_3_4_todos
      todo "Nothing todo for Alchemy 3.5 |o/", 'Alchemy v3.5 changes'
    end
  end
end
