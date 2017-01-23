# (c) Copyright 2017 Hewlett Packard Enterprise Development LP
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed
# under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
# CONDITIONS OF ANY KIND, either express or implied. See the License for the
# specific language governing permissions and limitations under the License.

require_relative '../../resource_provider'

module OneviewCookbook
  module API200
    # EnclosureGroup API200 provider
    class EnclosureGroupProvider < ResourceProvider
      def load_lig
        return unless @context.logical_interconnect_group
        lig_klass = OneviewSDK.resource_named(:LogicalInterconnectGroup, @sdk_api_version, @sdk_api_variant)
        @item.add_logical_interconnect_group(lig_klass.new(@item.client, name: @context.logical_interconnect_group))
      end

      def create_or_update
        load_lig
        super
      end

      def create_if_missing
        load_lig
        super
      end

      def set_script
        @item.retrieve!
        return Chef::Log.info("#{@resource_name} '#{@name}' script is up to date") if @item.get_script.eql?(@context.script)
        Chef::Log.debug "#{@resource_name} '#{@name}' Chef resource differs from OneView resource."
        @context.converge_by "Updated script for #{@resource_name} '#{@name}'" do
          @item.set_script(@context.script)
        end
      end
    end
  end
end