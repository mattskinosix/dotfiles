function kube_ps -a toggle
  if test "$toggle" = "on"
    set -U __kube_ps_enabled 1
    return
  end

  if test "$toggle" = "off"
    set -U __kube_ps_enabled 0
    return
  end
end
  
function dcleanup
    docker rm -v $(docker ps --filter status=exited -q 2>/dev/null) 2>/dev/null
    docker rmi $(docker images --filter dangling=true -q 2>/dev/null) 2>/dev/null
    return
  end


