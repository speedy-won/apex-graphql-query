public class GraphQLNode {
    public String name;
    public Boolean typeFrament; // transforms to "...on {NAME} {"
    public GraphQLArgument arg; //not sure this supports all use cases... might need to be GraphQLArgument | GraphQLArgument[]
    public Object[] children; //object or other nodes

    public GraphQLNode(String name){
        this.typeFrament = false;
        this.children = new Object[]{};
        this.name = name;
    }

    //returns the current node
    public GraphQLNode setArguments(GraphQLArgument arg){
        this.arg = arg;
        return this;
    }

    //returns the current node
    public GraphQLNode add(Object children){
        if(children instanceOf Object[]){
            this.children.addAll((Object[])children);
        }else{
            this.children.add(children);
        }
        return this;
    }

    public GraphQLNode setTypeFragment(Boolean isTypeFrag){
        this.typeFrament = isTypeFrag;
        return this;
    }

    private string buildInner(){
        String qry = this.name;
        if(this.typeFrament){
            qry = '... on ' + this.name;
        }
        
        if(this.arg != null){
            qry += '(' + this.arg.build() + ')';
        }
        qry += '{\n';
        for(Object child : this.children){
            if(child instanceOf GraphQLNode){
                qry += ((GraphQLNode) child).buildInner();
            }else{
                 qry += ((String) child) + '\n';
            }
        }
        qry += '}\n';
        return qry;
    }

    
    public string build(){
        return '{\n' + this.buildInner() + '\n}';
    }

}