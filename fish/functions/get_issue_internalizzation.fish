function get_issue_internalizzation --wraps=glab\ issue\ list\ -a=@me\ -l\ \'team::infrastructure\ architecture\' --description alias\ get_issue_internalizzation\ glab\ issue\ list\ -a=@me\ -l\ \'team::infrastructure\ architecture\'
  glab issue list -a=@me -l 'team::infrastructure architecture' $argv; 
end
