# == Class dummy::selinux
#
# This class is meant to be called from dummy.
# It ensures that selinux rules are defined.
#
class dummy::selinux {

  # FIXME: ensure your module's selinux settings are defined here.
  $msg = "FIXME: define the ${module_name} module's selinux settings."

  notify{ 'FIXME: selinux': message => $msg } # FIXME: remove this and add logic
  err( $msg )                                 # FIXME: remove this and add logic

}
