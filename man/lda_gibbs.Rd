\name{lda_gibbs}
\Rdversion{1.1}
\alias{lda_gibbs}

\title{
  Function to Fit LDA model
}
\description{
  This function uses a collapsed Gibbs sampler to fit a
  latent Dirichlet allocation (LDA). The function take
  sparsely represented input documents, perform inference, and return
  point estimates of the latent parameters using the state at the last
  iteration of Gibbs sampling.
}
\usage{
lda_gibbs(docs, K, vocab, num.iterations, alpha, eta, initial = NULL, 
                     burnin = 0L, compute.log.likelihood = FALSE, trace = 0L,
                     freeze.topics = FALSE, n.init = 0L)
}

\arguments{
  \item{documents}{
    A list whose length is equal to the number of documents, D.   Each
  element of \var{documents} is an integer matrix with two rows.  Each
  column of \var{documents[[i]]} (i.e., document \eqn{i}) represents a
  word occurring in the document.

  \var{documents[[i]][1, j]} is a
  0-indexed word identifier for the jth word in document i.  That is,
  this should be an index - 1 into \var{vocab}.  \var{documents[[i]][2,
  j]} is an integer specifying the number of times that word appears in
  the document.
}
  \item{K}{
    An integer representing the number of topics in the model.
}
  \item{vocab}{
    A character vector specifying the vocabulary words associated with
  the word indices used in \var{documents}. 
}
  \item{num.iterations}{
    The number of sweeps of Gibbs sampling over the entire corpus to make.
}
  \item{alpha}{
    The scalar value of the Dirichlet hyperparameter for
    topic proportions. 
  }
  \item{eta}{
    The scalar value of the Dirichlet hyperparamater for topic
    multinomials.
  }
  \item{initial}{
    A list of initial topic assignments for words.  It should be
  in the same format as the \var{assignments} field of the return
  value.  If this field is NULL, then the sampler will be initialized
  with random assignments.
  }
  \item{burnin}{
    A scalar integer indicating the number of Gibbs sweeps to consider
    as burn-in (i.e., throw away) for \code{lda.collapsed.gibbs.sampler}
    and \code{mmsb.collapsed.gibbs.sampler}.  If this parameter is non-NULL, it
    will also have the side-effect of enabling the
    \var{document_expects} field of the return value (see below for
    details).  Note that burnin iterations do NOT count towards \var{num.iterations}.
  }
  \item{compute.log.likelihood}{
    A scalar logical which when \code{TRUE} will cause the sampler to
  compute the log likelihood of the words (to within a constant
  factor) after each sweep over the variables.  The log likelihood for each
  iteration is stored in the \var{log.likelihood} field of the result.
  This is useful for assessing convergence, but slows things down a tiny
  bit.}
  \item{trace}{
    When \code{trace} is greater than zero, diagnostic messages will be
  output.  Larger values of \code{trace} imply more messages.
}
  \item{freeze.topics}{
    When \code{TRUE}, topic assignments will occur but the counts of
  words associated with topics will not change. \var{initial} should be
  set when this option is used. This is best use for sampling test
  documents.
}

}
\value{
A fitted model as a list with the following components:
  \item{assignments}{A list of length D.  Each element of the list, say
  \code{assignments[[i]]} is an integer vector of the same length as the
  number of columns in \code{documents[[i]]} indicating the topic
  assignment for each word.}  
  \item{topics}{A \eqn{K \times V} matrix where each entry indicates the
    number of times a word (column) was assigned to a topic (row).  The column
    names should correspond to the vocabulary words given in \var{vocab}.}
  \item{topic_sums}{A length K vector where each entry indicates the
    total number of times words were assigned to each topic.}
  \item{document_sums}{A \eqn{K \times D} matrix where each entry is an
    integer indicating the number of times words in each document
    (column) were assigned to each topic (row).}
  \item{log.likelihoods}{Only for \code{lda.collapsed.gibbs.sampler}.  A
    matrix with 2 rows and \code{num.iterations} columns of log likelihoods when the flag
    \code{compute.log.likelihood} is set to \code{TRUE}.  The first row
    contains the full log likelihood (including the prior), whereas the
    second row contains the log likelihood of the observations
    conditioned on the assignments.}
  \item{document_expects}{This field only exists if \var{burnin} is
    non-NULL. This field is like document_sums but instead of only
    aggregating counts for the last iteration, this field aggegates
    counts over all iterations after burnin.}  
}
\references{
  \cite{Blei, David M. and Ng, Andrew and Jordan, Michael. Latent
    Dirichlet allocation. Journal of Machine Learning Research, 2003.}
  \cite{Griffiths, Thomas L. and Steyvers, Mark.  Finding scientific
    topics.  Proceedings of the National Academy of Sciences, 2004.}
}
\author{
  Jonathan Chang
}
\note{
  WARNING: This function does not compute precisely the correct thing
    when the count associated with a word in a document is not 1 (this
    is for speed reasons currently).  A workaround when a word appears
    multiple times is to replicate the word across several columns of a
    document.  This will likely be fixed in a future version.
}

\seealso{
 \code{read.documents} and \code{lexicalize} can be used
    to generate the input data to these models.
}
\examples{
## See demos for the three functions:

\dontrun{#TODO}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ models }

