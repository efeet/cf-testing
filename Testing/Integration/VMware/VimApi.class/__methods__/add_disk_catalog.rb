#
# Description: This method is used to add a new disk to an existing VM running on VMware
#
# Inputs: $evm.root['vm'], size
#
attributes = $evm.root.attributes
vmname=attributes['dialog_get_vms']
vm= $evm.vmdb('vm').find_by_name(vmname) || $evm.root['vm']
raise "Missing $evm.root['vm'] object" unless vm

# Get the size for the new disk from the root object
size = $evm.root['dialog_size'].to_i
$evm.log("info", "Detected size:<#{size}>")

# Add disk to a VM
if size.zero?
  $evm.log("error", "Size:<#{size}> invalid")
else
  $evm.log("info", "Creating a new #{size}GB disk on Storage:<#{vm.storage_name}>")
  vm.add_disk("[#{vm.storage_name}]", size * 1024, :sync => true)
end
