public class Variavel {
    private String nome;
    private int tipo;
    private int escopo;

    public Variavel(String nome, int tipo, int escopo) {
        this.nome = nome;
        this.tipo = tipo;
        this.escopo = escopo;
    }

    public Variavel() {
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String name) {
        this.nome = name;
    }

    public int getTipo() {
        return tipo;
    }

    public void setTipo(int type) {
        this.tipo = type;
    }

    public int getEscopo() {
        return escopo;
    }

    public void setEscopo(int scope) {
        this.escopo = scope;
    }

    public void imprime() {
        System.out.println("Nome: " + nome + "\nTipo: " + tipo + "\nEscopo: " + escopo);
    }
}