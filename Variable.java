public class Variable {
    private String name;
    private int type;
    private int scope;

    public Variable(String name, int type, int scope) {
        this.name = name;
        this.type = type;
        this.scope = scope;
    }

    public Variable() {
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public int getScope() {
        return scope;
    }

    public void setScope(int scope) {
        this.scope = scope;
    }

    public void print() {
        System.out.println("Nome: " + name + "\nTipo: " + type + "\nEscopo: " + scope);
    }
}